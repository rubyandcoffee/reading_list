<!-- filepath: app/frontend/components/BookShow.vue -->
<template>
  <v-row>
    <v-col>
      <v-card width="320">
        <v-card-text>
          <div>
            <strong>Genres:</strong>
            <div v-if="book.genres && book.genres.length">
              <div v-for="genre in book.genres" :key="genre.id">
                <v-chip class="ma-1" color="primary" variant="outlined">
                  <a :href="genre.url" style="color: inherit; text-decoration: none;">{{ genre.name }}</a>
                </v-chip>
              </div>
            </div>
            <div v-else>
              <v-btn :href="editUrl" color="primary" variant="outlined">Add genre</v-btn>
            </div>
          </div>
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: "BookShow",
  props: {
    book: {
      type: Object,
      required: true
    }
  },
  computed: {
    editUrl() {
      return `/books/${this.book.id}/edit`;
    }
  }
}
</script>