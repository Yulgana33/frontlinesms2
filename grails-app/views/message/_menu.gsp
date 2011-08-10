<%@ page contentType="text/html;charset=UTF-8" %>
<ol class="context-menu" id="messages-menu">
	<li class="section">
		<img src='${resource(dir:'images/icons',file:'messages.gif')}' />
		<h2>Messages</h2>
		<ol class='sub-menu' id="messages-submenu">
			<li class="${(messageSection=='inbox')? 'selected':''}">
				<g:link action="inbox">Inbox (${messageCount['inbox']})</g:link>
			</li>
			<li class="${(messageSection=='sent')? 'selected':''}">
				<g:link action="sent">Sent (${messageCount['sent']})</g:link>
			</li>
			<li class="${(messageSection=='pending')? 'selected':''}">
				<g:link action="pending">Pending (${messageCount['pending']})</g:link>
			</li>
			<li class="${(messageSection=='trash')? 'selected':''}">
				<g:link action="trash">Trash</g:link>
			</li>
		</ol>
	</li>
	<li class="section">
		<img src='${resource(dir:'images/icons',file:'activities.gif')}' />
		<h2>Activities</h2>
		<ol class='sub-menu' id="activities-submenu">
			<g:each in="${pollInstanceList}" status="i" var="p">
				<li class="${p == ownerInstance ? 'selected' : ''}">
					<g:link action="poll" params="[ownerId: p.id]">${p.title} (${p.countMessages()})</g:link>
				</li>
			</g:each>
			<li class='create' id="create-poll">
				<g:remoteLink controller="poll" action="create" onSuccess="launchMediumWizard('Create Poll', data, 'Create');">
					Create new poll
				</g:remoteLink>				
			</li>
		</ol>
	</li>
	<li class="section">
		<img src='${resource(dir:'images/icons',file:'shows.gif')}' />
		<h2>Shows</h2>
		<ol class='sub-menu' id="shows-submenu">
			<g:each in="${radioShows}" status="i" var="s">
				<li class="${s == ownerInstance ? 'selected' : ''}">
					<g:link action="radioShow" params="[ownerId: s.id]">${s.name} (${s.countMessages()})</g:link>
				</li>
			</g:each>
			<li class="create" id='create-show'>
				<g:remoteLink controller="radioShow" action="create" onSuccess="launchSmallPopup('Radio Show', data, 'Create')">
					Create new show
				</g:remoteLink>
			</li>
		</ol>
	</li>
	<li class="section">
		<img src='${resource(dir:'images/icons',file:'folders.gif')}' />
		 <h2>Folders</h2>
	 	<ol class='sub-menu' >
			<g:each in="${folderInstanceList}" status="i" var="f">
				<li class="${f == ownerInstance ? 'selected' : ''}">
					<g:link action="folder" params="[ownerId: f.id]">${f.name} (${f.countMessages()})</g:link>
				</li>
			</g:each>
			<li class='create' id="create-folder">
				<g:remoteLink controller="folder" action="create" onSuccess="launchSmallPopup('Folder', data, 'Create');">
					Create new folder
				</g:remoteLink>
			</li>
		</ol>
	</li>
 </ol>
