<template>
  <v-timeline align="start" side="end">
    <v-timeline-item dot-color="pink" size="small" icon="mdi-numeric-1">
      <div class="d-flex">
        <strong class="me-4">Week 1</strong>
        <div>
          <div class="text-caption">
            {{ week_one }} pages
          </div>
        </div>
      </div>
    </v-timeline-item>

    <v-timeline-item dot-color="orange-lighten-1" size="small" icon="mdi-numeric-2">
      <div class="d-flex">
        <strong class="me-4">Week 2</strong>
        <div>
          <div class="text-caption">
            {{ week_two }} pages
          </div>
        </div>
      </div>
    </v-timeline-item>

    <v-timeline-item dot-color="yellow-darken-1" size="small" icon="mdi-numeric-3">
      <div class="d-flex">
        <strong class="me-4">Week 3</strong>
        <div>
          <div class="text-caption">
            {{ week_three }} pages
          </div>
        </div>
      </div>
    </v-timeline-item>

    <v-timeline-item dot-color="green-lighten-3" size="small" icon="mdi-numeric-4">
      <div class="d-flex">
        <strong class="me-4">Week 4</strong>
        <div>
          <div class="text-caption">
            {{ week_four }} pages
          </div>
        </div>
      </div>
    </v-timeline-item>
  </v-timeline>
</template>

<script>
export default {
  name: "BookGoalTimeline",
  props: {
    id: {
      type: [String, Number],
      required: true
    },
    week_one: {
      type: String,
      required: true
    },
    week_two: {
      type: String,
      required: true
    },
    week_three: {
      type: String,
      required: true
    },
    week_four: {
      type: String,
      required: true
    }
  }
};
</script>