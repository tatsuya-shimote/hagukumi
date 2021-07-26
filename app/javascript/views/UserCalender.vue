<template>
  <v-app>
    <v-sheet height="64">
      <v-toolbar flat color="white">
        <v-btn id="today" @click="setToday">
          今日
        </v-btn>
        <v-btn fab text small color="grey darken-2" @click="prev">
          <
        </v-btn>
        <span id="calendar-title" v-if="$refs.calendar">
          {{ $refs.calendar.title }}
        </span>
        <v-btn fab text small color="grey darken-2" @click="next">
          >
        </v-btn>
        
        <v-spacer></v-spacer>
        <v-menu
          bottom
          right
        >
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              v-bind="attrs"
              v-on="on"
              id="type-select-open"
            >
              <span>{{ typeToLabel[type] }}</span>
              <v-icon right>
                mdi-menu-down
              </v-icon>
            </v-btn>
          </template>
          <v-list id="calendar-type">
            <v-list-item @click="type = 'day'">
              <v-list-item-title>Day</v-list-item-title>
            </v-list-item>
            <v-list-item @click="type = 'month'">
              <v-list-item-title>Month</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-toolbar>
    </v-sheet>
    <v-sheet id="calendar">
        <v-calendar
          ref="calendar"
          v-model="focus"
          color="primary"
          interval-count="0"
          :events="this.$store.state.events"
          :event-color="getEventColor"
          :type="type"
          @click:more="viewDay"
          @click:date="viewDay"
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
            id="event-card"
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
            </v-toolbar>
            <v-card-text>
              <div v-if="errors.length != 0">
                <font color="red">{{ errors }}</font>
              </div>
              <v-text-field
                v-model="hug.count"
                filled
                color="blue"
                label="回数の修正(半角数字のみ)"
                clearable
              ></v-text-field>
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
    <v-snackbar
      v-model="snackbar"
      timeout="3000"
      color="light-blue"
      text
    >
      {{ message }}
    </v-snackbar>
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
      typeToLabel: {
        month: 'Month',
        day: 'Day',
      },
      errors:"",
      prepareEditHugCount:"",
      snackbar: false,
      message: ""
      
    }),
    mounted () {
      this.$refs.calendar.checkChange()
    },
    methods: {
      getEventColor (event) {
        return event.color
      },
      viewDay ({ date }) {
        this.focus = date
        this.type = 'day'
      },
      setToday () {
        this.focus = ''
        this.type = 'month'
      },
      prev () {
        this.$refs.calendar.prev()
      },
      next () {
        this.$refs.calendar.next()
      },
      showEvent ({ nativeEvent, event }) {
        const open = () => {
          this.selectedEvent = event;
          const dateTime = event.start.split("-");
          this.hug.count = this.selectedEvent.name;
          this.hug.year = dateTime[0];
          this.hug.month = dateTime[1];
          this.hug.date = dateTime[2];
          this.hug.hugId = this.selectedEvent.hug_id;
          console.log(this.hug)
          this.prepareEditHugCount = this.$store.getters.userHugCount - this.hug.count;
          this.selectedElement = nativeEvent.target;
          requestAnimationFrame(() => requestAnimationFrame(() => this.selectedOpen = true));
        };

        if (this.selectedOpen) {
          this.selectedOpen = false;
          requestAnimationFrame(() => requestAnimationFrame(() => open()));
        } else {
          open();
        }

        nativeEvent.stopPropagation();
      },
      updateHugRecord(){
        axios.patch(`/api/v1/hugs/${this.hug.hugId}.json`, this.hug, {headers: { 'X-Requested-With': 'XMLHttpRequest' }}, {withCredentials: true})
        .then(response => {
          const e = response.data
          this.$store.commit("updateHugCount", e)
          const editHugCount = this.prepareEditHugCount + response.data.count;
          this.$store.commit("updateHugCountSum", editHugCount);
          this.selectedOpen = false;
          this.message = "記録を修正しました"
          this.snackbar = "true"
          this.errors = ""
        }).catch(error => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      },
      deleteHugRecord(id){
        axios.delete(`/api/v1/hugs/${id}`)
        .then(response => {
          this.message = "記録を削除しました"
          this.snackbar = "true"
          this.selectedOpen = false;
        }).catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      },
      deletes(){
        this.$store.commit("subtractionHugCount", this.hug.count);
        const hugId = this.hug.hugId;
        this.deleteHugRecord(hugId);
        this.$store.commit("deleteEvent", hugId);
      }
    },
   
  };
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
#calendar-title,#today,#calendar-type,#type-select-open{
  font-family: 'Shippori Mincho', serif;
  font-size: 14px;
}

#calendar{
  height: 550px;
  width: 350px;
}

#event-card{
  width: 350px;
}

#calender .v-calendar-daily__head {
  height: 200px;
}

@media screen and (min-width: 768px){
  #calendar{
    height: 650px;
    width: 700px;
  }
  
  #event-card{
    width: 300px;
  }
}


</style>

