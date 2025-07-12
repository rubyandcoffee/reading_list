import { createApp } from 'vue'
import BookShow from '../components/BookShow.vue'
import BookForm from '../components/BookForm.vue'
import BookGoalTimelineShow from '../components/BookGoalTimelineShow.vue'
import BookGoalTimelineNew from '../components/BookGoalTimelineNew.vue'
import BookGoalTimelineIndex from '../components/BookGoalTimelineIndex.vue'
import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import '@mdi/font/css/materialdesignicons.css'

const vuetify = createVuetify({
  components,
  directives,
})
const componentsMap = { BookShow, BookForm, BookGoalTimelineShow, BookGoalTimelineNew, BookGoalTimelineIndex }

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('app');
  if (el) {
    const componentName = el.dataset.component
    const props = JSON.parse(el.dataset.props)
    const Component = componentsMap[componentName]
    if (Component) {
      createApp(Component, props)
        .use(vuetify)
        .mount('#app')
    }
  }
})
