import { Application } from "@hotwired/stimulus"
import ReadMore from '@stimulus-components/read-more'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
application.register('read-more', ReadMore)

export { application }
