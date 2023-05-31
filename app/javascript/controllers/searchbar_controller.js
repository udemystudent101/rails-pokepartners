import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {

  static targets = ['input', 'list', 'form']
  connect() {
    console.log("hello !")
  }

  searching() {

    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    const options = { headers: { 'Accept': 'application/json' }}
    fetch(url, options)
      .then(response => response.json())
      .then((data) => {
        console.log(data.list)
        this.listTarget.innerHTML = data.list
      })
  }
}
