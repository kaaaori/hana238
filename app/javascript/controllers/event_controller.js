// https://zenn.dev/necocoa/articles/rails-stimulus-tr-link参照
import { Controller } from 'stimulus'

export default class extends Controller {
  // 親要素のイベントを発生させたくない時に使う
  // <button data-controller="event" data-action="event#stopPropagation">
  stopPropagation(event) {
    event.stopPropagation()
  }
}