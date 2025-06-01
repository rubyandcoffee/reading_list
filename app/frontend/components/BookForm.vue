<!-- BookForm.vue -->
<template>
  <v-row>
    <v-col cols="12" md="6">
      <h4>Book Details</h4>
      <v-text-field
        v-model="form.title"
        label="Title"
        autofocus
        style="width: 400px"
      />

      <v-autocomplete
        v-model="form.author_id"
        :items="localAuthors"
        item-title="full_name"
        item-value="id"
        label="Author"
      />
      <span class="small-text">
        <a href="#" @click.prevent="showAuthorModal = true">Add missing author</a>
      </span>

      <v-select
        v-model="form.genre_ids"
        :items="genres"
        item-title="name"
        item-value="id"
        label="Genres"
        multiple
        creatable
        chips
      />

      <v-autocomplete
        v-model="form.series_id"
        :items="series"
        item-title="name"
        item-value="id"
        label="Series"
        return-object
        creatable
        @update:search="onSeriesSearch"
      />

      <v-text-field
        v-model="form.series_position"
        label="Series Position"
      />

      <span class="small-text">
        <a href="#" @click.prevent="showSeriesModal = true">Add missing series</a>
      </span>

      <v-text-field
        v-model="form.total_pages"
        label="Total Pages"
        type="number"
      />
    </v-col>

    <v-col cols="12" md="6">
      <h4>Reading Details</h4>
      <v-select
        v-model="form.status"
        :items="statuses"
        label="Status"
      />

      <v-card
        class="mb-4"
        outlined
        v-if="form.status === 'read'"
      >
        <v-card-title>Rating</v-card-title>
        <v-card-text>
          <v-rating
            v-model="form.rating"
            length="5"
            half-increments
            color="amber"
            background-color="grey lighten-2"
            large
          />
        </v-card-text>
      </v-card>

      <!-- Book goals, rentals, and other dynamic fields would go here -->
      <v-card class="mb-4" outlined>
        <v-card-title>Book Goals</v-card-title>
        <v-card-text>
          <div v-for="(goal, idx) in form.book_goals" :key="idx" class="d-flex align-center mb-2">
            <v-select
              v-model="goal.month"
              :items="months"
              label="Month"
              class="mr-2"
              style="max-width: 120px"
            />
            <v-select
              v-model="goal.year"
              :items="years"
              label="Year"
              class="mr-2"
              style="max-width: 100px"
            />
            <v-btn icon @click="removeGoal(idx)">
              <v-icon>mdi-delete</v-icon>
            </v-btn>
          </div>
          <v-btn small color="primary" @click="addGoal">Add Goal</v-btn>
        </v-card-text>
      </v-card>
      
      <v-card class="mb-4" outlined>
        <v-card-title>Shopping Bag</v-card-title>
        <v-card-text>
          <div class="d-flex align-center">
            <v-checkbox
              v-model="form.buy"
              label="Add to shopping list"
              class="mr-4"
            />
            <v-checkbox
              v-model="form.purchased"
              label="Already purchased"
            />
          </div>
          <v-checkbox
            v-model="form.rental_attributes.active"
            label="This book is a rental"
          />
          <v-row v-if="form.rental_attributes.active">
            <v-col cols="12" md="6">
              <v-autocomplete
                v-model="form.rental_attributes.loaner_id"
                :items="loaners"
                item-title="name"
                item-value="id"
                label="Loaner"
              />
            </v-col>
            <v-col cols="12" md="6">
              <v-menu
                v-model="rentalDueMenu"
                :close-on-content-click="false"
                transition="scale-transition"
                offset-y
                min-width="290px"
              >
                <template #activator="{ props }">
                  <v-text-field
                    v-bind="props"
                    v-model="form.rental_attributes.due_date"
                    label="Rental Due Date"
                    readonly
                    style="max-width: 200px"
                  />
                </template>
                <v-date-picker
                  v-model="form.rental_attributes.due_date"
                />
              </v-menu>
            </v-col>
          </v-row>
        </v-card-text>
      </v-card>

      <v-btn color="primary" @click="submitForm">Save</v-btn>
    </v-col>
  </v-row>

  <!-- Author Modal -->
  <v-dialog v-model="showAuthorModal" max-width="500">
    <v-card>
      <v-card-title>Add Author</v-card-title>
      <v-card-text>
        <v-text-field
          v-model="newAuthorForename"
          label="Forename"
          autofocus
        />
        <v-text-field
          v-model="newAuthorSurname"
          label="Surname"
        />
        <v-autocomplete
          v-model="newAuthorNationality"
          :items="countryNames"
          label="Nationality"
        />
        <v-select
          v-model="newAuthorGender"
          :items="['Male', 'Female']"
          label="Gender"
        />
      </v-card-text>
      <v-card-actions>
        <v-btn color="primary" @click="addAuthor">Add</v-btn>
        <v-btn text @click="showAuthorModal = false">Cancel</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>

  <!-- Series Modal -->
  <v-dialog v-model="showSeriesModal" max-width="500">
    <v-card>
      <v-card-title>Add Series</v-card-title>
      <v-card-text>
        <v-text-field
          v-model="newSeriesName"
          label="Series Name"
          autofocus
        />
        <v-autocomplete
          v-model="newSeriesAuthorId"
          :items="localAuthors"
          item-title="full_name"
          item-value="id"
          label="Author"
          style="margin-top: 16px"
          creatable
          @update:search="onSeriesAuthorSearch"
        />
      </v-card-text>
      <v-card-actions>
        <v-btn color="primary" @click="addSeries">Add</v-btn>
        <v-btn text @click="showSeriesModal = false">Cancel</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { countries } from 'countries-list'

export default {
  name: "BookForm",
  props: {
    book: Object,
    authors: Array,
    genres: Array,
    series: Array,
    loaners: Array, // <-- add this line
  },
  data() {
    return {
      localAuthors: [...this.authors],
      statuses: ['unread', 'reading', 'read', 'dnf'],
      countryNames: Object.values(countries).map(c => c.name),
      months: [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ],
      years: Array.from({ length: 11 }, (_, i) => String(new Date().getFullYear() + i)),
      form: {
        title: this.book?.title || "",
        author_id: this.book?.author_id || null,
        genre_ids: this.book?.genres || [],
        series_id: this.book?.series_id || null,
        series_position: this.book?.series_position || "",
        total_pages: this.book?.total_pages || "",
        status: this.book?.status || null,
        purchased: this.book?.purchased || false,
        buy: this.book?.buy || false,
        book_goals: this.book?.book_goals || [],
        rating: this.book?.rating || 0,
        rental_attributes: {
          id: this.book?.rental?.id || null,
          loaner_id: this.book?.rental?.loaner_id || null,
          active: !!this.book?.rental?.active,
          due_date: this.book?.rental?.due_date || null
        },
        // Add other fields as needed
      },
      showAuthorModal: false,
      showGenreModal: false,
      showSeriesModal: false,
      newGenreName: '',
      newAuthorForename: '',
      newAuthorSurname: '',
      newAuthorNationality: '',
      newAuthorGender: '',
      rentalDueMenu: false,
      newSeriesName: '',
      newSeriesAuthorId: null, // <-- add this line
    }
  },
  methods: {
    async submitForm() {
      // Remove id from new goals if creating
      if (!this.book?.id) {
        this.form.book_goals.forEach(goal => { delete goal.id });
      }

      const book_goals_attributes = this.form.book_goals.map(goal => {
        const attrs = {
          month: goal.month,
          year: goal.year,
          _destroy: goal._destroy || false
        };
        if (goal.id) attrs.id = goal.id;
        return attrs;
      });

      const rental_attributes = this.form.rental_attributes;

      let series_id = this.form.series_id;
      if (typeof series_id === 'object' && series_id !== null) {
        series_id = series_id.id;
      }

      const payload = {
        ...this.form,
        id: this.book?.id,
        series_id,
        book_goals_attributes,
        rental_attributes
      };
      delete payload.book_goals;

      const isEdit = !!this.book?.id;
      const url = isEdit ? `/books/${this.book.id}` : '/books';
      const method = isEdit ? 'PATCH' : 'POST';

      try {
        const response = await fetch(url, {
          method,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: JSON.stringify({ book: payload })
        });
        if (!response.ok) {
          let errorMsg = 'Unknown error';
          try {
            const error = await response.json();
            console.error('Server error:', error);
            if (error.errors) {
              if (Array.isArray(error.errors)) {
                errorMsg = error.errors.join('\n');
              } else if (typeof error.errors === 'object') {
                errorMsg = Object.entries(error.errors)
                  .map(([field, messages]) => `${field}: ${messages.join(', ')}`)
                  .join('\n');
              }
            } else if (typeof error === 'object') {
              // Rails returns errors as a hash directly
              errorMsg = Object.entries(error)
                .map(([field, messages]) => `${field}: ${messages.join(', ')}`)
                .join('\n');
            } else if (typeof error === 'string') {
              errorMsg = error;
            }
          } catch (parseErr) {
            errorMsg = response.statusText;
          }
          alert('Error: ' + errorMsg);
        } else {
          const data = await response.json();
          // Redirect to /books after successful save
          window.location.href = '/books?notice=Book%20added%20successfully';
        }
      } catch (e) {
        console.error('Network or JS error:', e);
        alert('Network error: ' + e.message);
      }
    },
    async addAuthor() {
      // Build the author object from modal fields
      const newAuthor = {
        forename: this.newAuthorForename,
        surname: this.newAuthorSurname,
        nationality: this.newAuthorNationality,
        gender: this.newAuthorGender
      };
      console.log('Submitting author:', newAuthor);
      try {
        const response = await fetch('/authors', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json', // <-- add this line
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: JSON.stringify({ author: newAuthor })
        });
        if (!response.ok) throw new Error('Failed to create author');
        const created = await response.json();
        created.full_name = `${created.forename} ${created.surname}`;
        this.localAuthors.push(created);
        this.form.author_id = created.id;
        this.showAuthorModal = false;
        // Optionally clear modal fields
        this.newAuthorForename = '';
        this.newAuthorSurname = '';
        this.newAuthorNationality = '';
        this.newAuthorGender = '';
      } catch (e) {
        alert('Could not add author');
      }
    },
    async addSeries() {
      const newSeries = {
        name: this.newSeriesName,
        author_id: this.newSeriesAuthorId
      };
      try {
        const response = await fetch('/series', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json', // <-- add this line
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: JSON.stringify({ series: newSeries })
        });
        if (!response.ok) throw new Error('Failed to create series');
        const created = await response.json();
        this.series.push(created);
        this.form.series_id = created;
        this.showSeriesModal = false;
        // Optionally clear modal fields
        this.newSeriesName = '';
        this.newSeriesAuthorId = null;
      } catch (e) {
        alert('Could not add series');
      }
    },
    addGoal() {
      this.form.book_goals.push({
        month: '',
        year: '',
        _destroy: false
        // Do NOT include id for new goals
      })
    },
    removeGoal(idx) {
      this.form.book_goals.splice(idx, 1)
    },
    onRentalSourceSearch(val) {
      if (
        val &&
        !this.rentalSources.includes(val) &&
        !this.rentalSources.some(source => source.toLowerCase() === val.toLowerCase())
      ) {
        this.rentalSources.push(val)
      }
    },
    onSeriesAuthorSearch(val) {
      if (
        val &&
        !this.authors.some(a => a.full_name.toLowerCase() === val.toLowerCase())
      ) {
        // Add a new author object with a temporary ID and the entered name
        this.authors.push({
          id: Date.now(),
          full_name: val
        })
      }
    },
    onSeriesSearch(val) {
      if (
        val &&
        !this.series.some(s => s.name.toLowerCase() === val.toLowerCase())
      ) {
        // Add a new series object with a temporary ID and the entered name
        this.series.push({
          id: Date.now(),
          name: val
        })
      }
    },
    onGoalMonthYearChange(val, goal) {
      if (!val) return;
      // val will be in "YYYY-MM" format
      const [year, month, day] = goal.date.split('-')
      goal.year = year;
      goal.month = month;
      goal.menu = false;
    },
  }
}
</script>