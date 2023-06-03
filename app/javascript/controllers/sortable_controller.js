import { Controller } from "@hotwired/stimulus"
// import { initSortable } from "./components/init_sortable.js"
import Sortable from "sortablejs"

// Controller used two times
// In my_bookings and pokemon index


// Connects to data-controller="sortable"
export default class extends Controller {

  static targets = ["list"]

  connect() {
    console.log("hello!!!!")
    console.log(this.listTarget)

    new Sortable(this.listTarget, {
      animation: 300,
      ghostClass: 'blue-background-class'
    });

    // const initSortable = () => {
    //   Sortable.create(this.listTarget, {
    //     ghostClass: "ghost",
    //     animation: 150,
    //   })
    // }

    // initSortable()

  }

}
