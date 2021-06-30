import Vue from "vue";
import Router from "vue-router";
import store from './store'
const TopPage = () => import(/* webpackChunkName: "TopPage" */"./views/TopPage.vue");
const TopHeader = () => import(/* webpackChunkName: "TopHeader" */'./views/TopHeader.vue') 
const Signup = () => import(/* webpackChunkName: "Signup" */'./views/Signup.vue') 
const LoginPage = () => import(/* webpackChunkName: "LoginPage" */'./views/LoginPage.vue') 
const UserHome = () => import(/* webpackChunkName: "UserHome" */'./views/UserHome.vue') 
const UserHeader = () => import(/* webpackChunkName: "UserHeader" */'./views/UserHeader.vue')
const UserProfileEdit = () => import(/* webpackChunkName: "UserProfileEdit" */'./views/UserProfileEdit.vue')
const UserProfileHeader = () => import(/* webpackChunkName: "UserProfileHeader" */'./views/UserProfileHeader.vue')
const UserIndex = () => import(/* webpackChunkName: "UserIndex" */'./views/UserIndex.vue')
const UserIndexHeader = () => import(/* webpackChunkName: "UserIndexHeader" */'./views/UserIndexHeader.vue')
const UserProfile = () => import(/* webpackChunkName: "UserProfile" */'./views/UserProfile.vue')
Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
      {
        path: "/", 
        components: {
            default: TopPage,
            header: TopHeader
        },
        name: 'root_path'
      },
      {
        path: "/signup", 
        components: {
            default: Signup,
            header: TopHeader
        },
        name: 'signup_path'
      },
      {
        path: "/login", 
        components: {
            default: LoginPage,
            header: TopHeader
        },
        name: 'login_path'
      },
      {
        path: "/users/:id", 
        components: {
            default: UserHome,
            header: UserHeader
        },
        name: 'user-home'
        // beforeEnter(to, from, next) {
        //   if (store.getters.idToken) {
        //     next();
        //   } else {
        //     next('/login');
        //   }
        // }
      },
      {
        path: "/users/:id/edit",
        components: {
            default: UserProfileEdit,
            header: UserProfileHeader
        },
        name: 'edit_path'
      },
      {
        path: "/users",
        components: {
            default: UserIndex,
            header: UserIndexHeader
        },
        name: 'users_path'
      },
      {
        path: "/users/:id/profile",
        components: {
            default: UserProfile,
            header: UserIndexHeader
        },
        name: 'profile_path'
      }
    ]
})