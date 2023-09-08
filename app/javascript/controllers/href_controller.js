// https://zenn.dev/necocoa/articles/rails-stimulus-tr-link参照
import { Controller } from 'stimulus'

export default class extends Controller {
  // 親要素のdata-href属性にあるパスに遷移する
  toHref(event) {
    event.preventDefault()
    const href = event.currentTarget.dataset['href']
    window.location.href = href
  }

  // フォーカスした要素上でエンターを押した時、遷移する(エンター押しても遷移できていない;;)
  enterToHref(event) {
    if (event.target !== event.currentTarget) return

    if (event.key === 'Enter') {
      this.toHref(event)
    }
  }
}