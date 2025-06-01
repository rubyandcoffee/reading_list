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
        :items="authors"
        item-title="full_name"
        item-value="id"
        label="Author"
        style="width: 300px"
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
            <!-- Start Date Picker -->
            <v-menu
              v-model="goal.startMenu"
              :close-on-content-click="false"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template #activator="{ props }">
                <v-text-field
                  v-bind="props"
                  v-model="goal.start_date"
                  label="Start Date"
                  readonly
                  class="mr-2"
                  style="max-width: 200px;"
                />
              </template>
              <v-date-picker
                v-model="goal.start_date"
                @update:model-value="goal.startMenu = false"
              />
            </v-menu>

            <!-- End Date Picker -->
            <v-menu
              v-model="goal.endMenu"
              :close-on-content-click="false"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template #activator="{ props }">
                <v-text-field
                  v-bind="props"
                  v-model="goal.end_date"
                  label="End Date"
                  readonly
                  class="mr-2"
                  style="max-width: 250px"
                />
              </template>
              <v-date-picker
                v-model="goal.end_date"
                @update:model-value="goal.endMenu = false"
              />
            </v-menu>
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
            <v-checkbox
            v-model="form.rental"
            label="This book is a rental"
            />
            </div>
          <div v-if="form.rental" class="d-flex align-center mb-2">
            <v-menu
              v-if="form.rental"
              v-model="form.rentalDueMenu"
              :close-on-content-click="false"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template #activator="{ props }">
                <v-text-field
                  v-bind="props"
                  v-model="form.rental_due_date"
                  label="Rental Due Date"
                  readonly
                  style="max-width: 200px"
                />
              </template>
              <v-date-picker
                v-model="form.rental_due_date"
                @update:model-value="form.rentalDueMenu = false"
              />
            </v-menu>
            <v-autocomplete
              v-if="form.rental"
              v-model="form.rental_source"
              :items="rentalSources"
              label="Rental Source"
              style="margin-left: 16px"
              creatable
              @update:search="onRentalSourceSearch"
            />
          </div>
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
          :items="authors"
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
  },
  data() {
    return {
      statuses: ['unread', 'reading', 'read', 'dnf'],
      countryNames: Object.values(countries).map(c => c.name),
      form: {
        title: this.book?.title || "",
        author_id: this.book?.author_id || null,
        genre_ids: this.book?.genre_ids || [],
        series_id: this.book?.series_id || null,
        series_position: this.book?.series_position || "",
        total_pages: this.book?.total_pages || "",
        status: this.book?.status || null,
        purchased: this.book?.purchased || false,
        buy: this.book?.buy || false,
        rental: this.book?.rental || false,
        rental_due_date: this.book?.rental_due_date || "",
        rental_source: this.book?.rental_source || "",
        book_goals: this.book?.book_goals || [],
        rating: this.book?.rating || 0,
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
      rentalSources: ["Kindle", "Library", "Mum", "Laura"],
      rentalDueMenu: false,
    }
  },
  methods: {
    submitForm() {
      // Implement AJAX submission or emit event to parent
      // Example: this.$emit('submit', this.form)
    },
    addAuthor() {
      // Logic to add a new author
      // Similar to addGenre, this could be an API call or Vuex action
      this.showAuthorModal = false;
    },
    addSeries() {
      // Logic to add a new series
      // Similar to addGenre, this could be an API call or Vuex action
      this.showSeriesModal = false;
    },
    addGoal() {
      this.form.book_goals.push({
        start_date: null,
        end_date: null,
        startMenu: false,
        endMenu: false
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
    formatLongDate(date) {
      if (!date) return '';
      const d = new Date(date);
      return d.toLocaleDateString('en-GB', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
    }
  }
}
</script>