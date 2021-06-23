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
          :event-color="getEventColor"
          :type="type"
          @click:event="showEvent"
        >
        </v-calendar>
        <v-menu
          v-model="selectedOpen"
          :close-on-content-click="false"
          :activator="selectedElement"
          offset-x
        >
          <v-card
            color="grey lighten-4"
            min-width="350px"
            flat
          >
            <v-toolbar
              :color="selectedEvent.color"
              dark
            >
              <v-btn icon>
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
              <v-toolbar-title>編集・削除</v-toolbar-title>
              <v-spacer></v-spacer>
              <v-btn icon>
                <v-icon>mdi-heart</v-icon>
              </v-btn>
              <v-btn icon>
                <v-icon>mdi-dots-vertical</v-icon>
              </v-btn>
            </v-toolbar>
            <v-card-text>
              <div v-if="errors.length != 0">
                <ul v-for="(e, index) in errors" :key="index">
                  <li><font color="red">{{ e }}</font></li>
                </ul>
              </div>
              <span>{{hug.count}}</span>
              <input v-model="hug.count">
            </v-card-text>
            <v-card-actions>
              <v-btn
                text
                color="green"
                @click="updateHugRecord"
              >
                保存
              </v-btn>
              <v-btn
                text
                color="red"
                @click="deletes"
              >
                削除
              </v-btn>
              <v-btn
                text
                color="secondary"
                @click="selectedOpen = false"
              >
                Cancel
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-menu>
    </v-sheet>
    
  </v-app>
</template>

<script>
import axios from "axios"
  export default {
    props:["hug"],
    data: () => ({
      focus: '',
      dialog: false,
      type: 'month',
      selectedEvent: {},
      selectedElement: null,
      selectedOpen: false,
      // hug: {
      //     count: "",
      //     year: "",
      //     month: "",
      //     date: "",
      //     hugId: ""
      //   },
      errors:""
      
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
      },
      showEvent ({ nativeEvent, event }) {
        const open = () => {
          this.selectedEvent = event
          console.log(event)
          const dateTime = event.start.split("-")
          this.hug.count = this.selectedEvent.name
          this.hug.year = dateTime[0]
          this.hug.month = dateTime[1]
          this.hug.date = dateTime[2]
          this.hug.hugId = this.selectedEvent.hug_id
          this.selectedElement = nativeEvent.target
          requestAnimationFrame(() => requestAnimationFrame(() => this.selectedOpen = true))
        }

        if (this.selectedOpen) {
          this.selectedOpen = false
          requestAnimationFrame(() => requestAnimationFrame(() => open()))
        } else {
          open()
        }

        nativeEvent.stopPropagation()
      },
      updateHugRecord(){
        axios.patch(`/api/v1/hugs/${this.hug.hugId}.json`, this.hug, {headers: { 'X-Requested-With': 'XMLHttpRequest' }}, {withCredentials: true})
        .then(response => {
          console.log(response)
        }).catch(error => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        })
      },
      deleteHugRecord(id){
        axios.delete(`/api/v1/hugs/${id}`)
        .then(response => {
          console.log(response)
          this.selectedOpen = false
        }).catch(error => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        })
      },
      deletes(){
        const hugId = this.hug.hugId
        this.deleteHugRecord(hugId)
        this.$store.commit("deleteEvent", hugId)
      }
    }
  }
</script>



