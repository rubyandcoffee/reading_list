<template>
  <v-expansion-panels multiple>
    <v-expansion-panel
      v-for="month in orderedMonths"
      :key="month"
      :title="month"
    >
      <v-list>
        <v-list-item
          v-for="goal in groupedByMonth[month]"
          :key="goal.id"
        >
          <v-list-item-content>
            <v-list-item-title>
              {{ goal.book.title }} by {{ goal.book.author_id }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-expansion-panel>
  </v-expansion-panels>
</template>

<script>
export default {
  props: {
    bookGoals: {
      type: Array,
      required: true
    }
  },
  computed: {
    groupedByMonth() {
      // Group bookGoals by month
      return this.bookGoals.reduce((acc, goal) => {
        if (!acc[goal.month]) acc[goal.month] = [];
        acc[goal.month].push(goal);
        return acc;
      }, {});
    },
    orderedMonths() {
      // List of months in order
      const monthsOrder = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      // Only include months that are present in groupedByMonth
      return monthsOrder.filter(m => this.groupedByMonth[m]);
    }
  }
}
</script>