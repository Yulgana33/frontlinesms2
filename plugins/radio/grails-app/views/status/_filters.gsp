<g:if test="${groupInstanceList || activityInstanceList || folderInstanceList || radioShowInstanceList}">
	<ul id="type-filters" class="sub-menu">
		<li>
			<g:select class="dropdown" name="groupId" from="${groupInstanceList}" value="${search?.group?.id}"
					  optionKey="id" optionValue="name"
					  noSelection="${['':'Show all groups']}"/>
		</li>
		<li>
			<g:select class="dropdown" name="activityId" from="${activityInstanceList + folderInstanceList + radioShowInstanceList}"
					  value="${search?.activityId}"
					  optionKey="${{it.id}}"
					  optionValue="${{it.name}}"
					  noSelection="${['':'Show all activities/folders/shows']}"/>
		</li>
	</ul>
</g:if>
<ul id="time-filters">
	<li>
		<g:radio name="rangeOption" value="two-weeks" checked="${params.rangeOption == 'two-weeks'}" />
		<g:select class="dropdown" id="pre-defined-range-options" name='pre-defined-range-options'
		    noSelection="${['null':'Show last two weeks']}" >
		</g:select>
	</li>
	<li>
		<g:radio name="rangeOption" value="between-dates" checked="${params.rangeOption == 'between-dates'}"/>
		<span id="dates-text">Between dates</span>
	</li>
	<li class='datepicker'><g:datePicker class='datepicker' name="startDate" value="${params['startDate'] ?: new Date()-14}" noSelection="['':'-Choose-']" precision="day"/></li>
	<li class='datepicker'><g:datePicker class='datepicker' name="endDate" value="${params['endDate'] ?: new Date()}" noSelection="['':'-Choose-']" precision="day"/></li>
</ul>
