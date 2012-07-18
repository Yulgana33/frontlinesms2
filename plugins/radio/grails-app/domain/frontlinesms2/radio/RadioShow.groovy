package frontlinesms2.radio

import java.util.Date
import frontlinesms2.*

class RadioShow extends MessageOwner {
	String name
	boolean isRunning
	Date dateCreated
	List activities = []
	static boolean editable = false
	static hasMany = [activities: Activity]
	static String getShortName() { "radioShow" }
	static transients = ['liveMessageCount']
	
	static constraints = {
		name(blank: false, validator: {val, obj ->
				def similarName = RadioShow.findByNameIlike(val)
				return !similarName|| obj.id == similarName.id
			})
	}

	static namedQueries = {
		findByOwnedActivity { activityInstance ->
				activities {
					eq 'id', activityInstance.id
				}
		}
	}
	
	def getShowMessages(getOnlyStarred = false, getSent=false) {
		Fmessage.owned(this, getOnlyStarred, getSent)
	}

	def getLiveMessageCount() {
		def m = Fmessage.findAllByMessageOwnerAndIsDeleted(this, false)
		m ? m.size() : 0
	}
	
	def start() {
		if(RadioShow.findByIsRunning(true)) {
			return false
		} else {
			this.isRunning = true
		}
	}
	
	def stop() {
		isRunning = false
	}
	
	def getActiveActivities() {
		def activityInstanceList
		if(activities) {
			activityInstanceList = Activity.withCriteria {
				'in'("id", activities*.id)
				eq("archived", false)
				eq("deleted", false)
			}
		}
		activityInstanceList
	}

	def archive() {
		this.archived = true
		this.messages.each {
			it.archived = true
			it.save(flush: true)
		}
		this.activities?.each {
			it.archive()
			it.save(flush: true)
		}
	}
	
	def unarchive() {
		this.archived = false
		def messagesToArchive = Fmessage?.owned(this, false, true)?.list()
		messagesToArchive.each { it?.archived = false }
	}

	void addToActivities(Activity activityInstance) {
		removeFromRadioShow(activityInstance)
		this.activities.add(activityInstance)
	}
	
	void removeFromRadioShow(Activity activityInstance) {
		RadioShow.findAll().collect { showInstance ->
			if(activityInstance in showInstance.activities) {
				showInstance.removeFromActivities(activityInstance)
			}
		}
	}

	static def getAllRadioActivities() {
		def radioActivitiesInstanceList = RadioShow.findAll()*.activeActivities
		radioActivitiesInstanceList.flatten()
	}
}
