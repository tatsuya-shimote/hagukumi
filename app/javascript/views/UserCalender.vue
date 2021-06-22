<template>
  <v-app>
    <v-sheet height="64">
      <v-toolbar flat color="white">
        <v-btn outlined class="mr-4" color="grey darken-2" @click="setToday">
          今日
        </v-btn>
        <v-btn fab text small color="grey darken-2" @click="prev">
          <
        </v-btn>
        <v-toolbar-title v-if="$refs.calendar">
          {{ $refs.calendar.title }}
        </v-toolbar-title>
        <v-btn fab text small color="grey darken-2" @click="next">
          >
        </v-btn>
        
        <v-spacer></v-spacer>
        
      </v-toolbar>
    </v-sheet>
    <v-sheet height="600" width="350">
        <v-calendar
          ref="calendar"
          v-model="focus"
          color="primary"
          :events="this.$store.state.events"
          :type="type"
        >
        </v-calendar>
    </v-sheet>
    
  </v-app>
</template>

<script>
  export default {
    data: () => ({
      focus: '',
      dialog: false,
      type: 'month',
      selectedEvent: {},
      selectedElement: null,
      selectedOpen: false,
    }),
    mounted () {
      this.$refs.calendar.checkChange()
    },
    methods: {
      getEventColor (event) {
        return event.color
      },
      setToday () {
        this.focus = ''
      },
      prev () {
        this.$refs.calendar.prev()
      },
      next () {
        this.$refs.calendar.next()
      }
    }
  }
</script>



