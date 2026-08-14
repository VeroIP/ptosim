import { Controller } from "@hotwired/stimulus"

// Copy a string to the clipboard and briefly show a "copied" state.
//
// Data attributes:
//   data-clipboard-text-value          — the text to copy
//   data-clipboard-copied-label-value  — text shown for the reset window (labeled variant)
//   data-clipboard-reset-after-value   — ms before reverting (default 1500)
//
// Targets:
//   data-clipboard-target="label"      — element whose textContent is swapped (optional, labeled variant)
export default class extends Controller {
  static values = {
    text: String,
    copiedLabel: { type: String, default: "Copied" },
    resetAfter: { type: Number, default: 1500 }
  }
  static targets = ["label"]
  static classes = ["copied"]

  connect() {
    this.copiedClass = "ps-copy-btn-copied"
  }

  async copy(event) {
    event.preventDefault()
    if (this.resetTimer) clearTimeout(this.resetTimer)

    try {
      await this.write(this.textValue)
    } catch (err) {
      console.warn("clipboard copy failed:", err)
      return
    }

    let originalLabel
    if (this.hasLabelTarget) {
      originalLabel = this.labelTarget.textContent
      this.labelTarget.textContent = this.copiedLabelValue
    }
    this.element.classList.add(this.copiedClass)

    this.resetTimer = setTimeout(() => {
      if (this.hasLabelTarget) this.labelTarget.textContent = originalLabel
      this.element.classList.remove(this.copiedClass)
    }, this.resetAfterValue)
  }

  async write(text) {
    if (navigator.clipboard && window.isSecureContext) {
      return navigator.clipboard.writeText(text)
    }
    // Fallback for non-secure contexts (rare in dev over http://localhost, which IS secure).
    const ta = document.createElement("textarea")
    ta.value = text
    ta.setAttribute("readonly", "")
    ta.style.position = "fixed"
    ta.style.opacity = "0"
    document.body.appendChild(ta)
    ta.select()
    const ok = document.execCommand("copy")
    document.body.removeChild(ta)
    if (!ok) throw new Error("execCommand copy failed")
  }
}
