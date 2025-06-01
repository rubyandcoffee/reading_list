<template>
  <v-form @submit.prevent="submitForm" ref="form">
    <v-text-field
      v-model="book_goal_id"
      :items="bookGoals"
      item-title="title"
      item-value="id"
      label="Select Book Goal"
      required
    ></v-text-field>
    <v-text-field
      v-model="week_one"
      label="Pages to read in Week 1"
      required
    ></v-text-field>
    <v-text-field
      v-model="week_two"
      label="Pages to read in Week 2"
      required
    ></v-text-field>
    <v-text-field
      v-model="week_three"
      label="Pages to read in Week 3"
      required
    ></v-text-field>
    <v-text-field
      v-model="week_four"
      label="Pages to read in Week 4"
      required
    ></v-text-field>
    <v-btn type="submit" color="primary">Create Book Goal Timeline</v-btn>
    <v-alert v-if="error" type="error" class="mt-2">{{ error }}</v-alert>
    <v-alert v-if="success" type="success" class="mt-2">Book Goal Timeline created!</v-alert>
  </v-form>
</template>

<script>
export default {
  name: "BookGoalTimelineNew",
  props: {
    book_goal_id: {
      type: [String, Number],
      required: true
    }
  },
  data() {
    return {
      book_goal_id: this.book_goal_id,
      week_one: "",
      week_two: "",
      week_three: "",
      week_four: "",
      error: null,
      success: false
    };
  },
  methods: {
    async submitForm() {
      this.error = null;
      this.success = false;
      try {
        const response = await fetch("/book_goal_timelines", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
          },
          body: JSON.stringify({
            book_goal_timeline: {
              book_goal_id: this.book_goal_id,
              week_one: this.week_one,
              week_two: this.week_two,
              week_three: this.week_three,
              week_four: this.week_four
            }
          })
        });
        if (!response.ok) {
          const data = await response.json();
          this.error = data.error || "Failed to create Book Goal Timeline.";
        } else {
          this.success = true;
          this.book_goal_id = null;
          this.week_one = "";
          this.week_two = "";
          this.week_three = "";
          this.week_four = "";
        }
      } catch (e) {
        this.error = "Network error.";
      }
    }
  }
};
</script>