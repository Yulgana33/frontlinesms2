package frontlinesms2

class MessageController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "inbox", params: params)
    }

    def inbox = {
		def messageInstance = Fmessage.get(params.id)
		params.inbound = true
		return [messageSection:'inbox',
				messageInstance: messageInstance] << list()
    }

    def sent = {
		params.inbound = false
		[messageSection:'sent'] << list()
    }

    def list = {
		[messageInstanceList:Fmessage.findAllByInbound(params.inbound, params),
				messageInstanceTotal:Fmessage.countByInbound(params.inbound)]
    }
}
