import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-calculation"
export default class extends Controller {
  static targets = ['start', "end", "price"]
  static values = { price: Number }
  connect() {
    this.priceTarget.innerHTML = "Total Price : " + this.priceValue + " ₽"
  }

  calculate(event) {
    const calculation = (Date.parse(this.endTarget.value) - Date.parse(this.startTarget.value)) / (1000 * 3600 * 24)
    if (calculation >= 0) {
      this.priceTarget.innerHTML = "Prix total : " + this.priceValue * calculation + " ₽"
    } else {
      this.priceTarget.innerHTML = "Erreur sur les dates !!"
    }
  }
}
