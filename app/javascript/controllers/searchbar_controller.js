import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {

  static targets = ['input', 'list', 'form']
  connect() {
    console.log("hello !")
    console.log(this.inputTarget)
    console.log(this.listTarget)
    console.log(this.formTarget)
  }

  searching() {
    console.log(this.inputTarget.value)
    console.log("key pressed")
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    const options = { headers: { 'Accept': 'text/plain' }}
    // http://localhost:3000/pokemons?query=arca
    fetch(url, options)
      .then(response => response.text())
      .then((data) => {
        // this.listTarget.insertAdjacentHTML("beforeend", data)
        this.listTarget.outerHTML = data
      })
  }
}
