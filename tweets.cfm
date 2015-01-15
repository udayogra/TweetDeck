<!---
	Custom tag to display tweets
	Attributes :
		parent - Id of parent div 
--->

<cfclient>
	<cfif thisTag.executionMode eq "start">
		<cfset display_tweets('cricket',10)>
	</cfif>
	<cffunction name="display_tweets" >
	  <cfargument name="tweet" >
	  <cfargument name="tweetcount" >
 
	 	
		<cfset window.tweet_util.search_tweets(tweet,tweetcount, on_tweets_received)>
		
		<cfset var parent_div = $("##"+attributes.parent)>
		
		<cfset $(parent_div).html("")>

		<cfsavecontent variable="tmphtml" >
			<div id="tweets_div"></div>
		</cfsavecontent>
		<cfset $(parent_div).append(tmphtml)>
		<cfsavecontent variable="tmphtml" >
			<p class="tweet-progress" style="margin-top:30px">
				<div class="progress progress-striped active" id="progid">
					<div class="progress-bar"  role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
					</div>
				</div>
			</p>			
		</cfsavecontent>
						
		
	</cffunction>
	
	<cffunction name="on_tweets_received" >
		<cfargument name="tweets" >
		<cfargument name="tweet" >
 
                <cfset var parent_div = $("##"+window.mainDivId)>
                <cfset console.log(parent_div)>
		<cfset console.log(tweets.search_metadata)>
		
                <cfset console.log(tweets.statuses)>
		
		<cfset $(parent_div).html("")>
		
		<cfset count = tweets.statuses.length>
		<cfset $(parent_div).html('<b>Enter keyword</b>  : <input type="text" id="tweet" value="#tweets.search_metadata.query#"></input> <B>Number of tweets</b>  : <input type="text" id="tweetcount" value="#tweets.search_metadata.count#"></input> <button class="ui-btn ui-btn-inline ui-corner-all tweetbutton" >Get Tweets</button>')>
		<cfif tweets.statuses.length eq 0>
			<cfset $(parent_div).html('<span class="label label-warning tag">No tweets found</span>')>
			<cfset $(parent_div).html('Enter keyword  : <input type="text" id="tweet" value="#tweets.search_metadata.query#"></input> Number of tweets  : <input type="text" id="tweetcount" value=""></input> <button class="ui-btn ui-btn-inline ui-corner-all tweetbutton" >Get Tweets</button>')>
			<cfreturn >
		</cfif>
		
		<cfsavecontent variable="tmphtml" >
			<div class='nav nav-list' id="tweets_list" style='margin: 0 auto;
width: 500px;'>			
		</cfsavecontent>
		<cfset var table_obj = $(tmphtml).appendTo(parent_div)>
		
		<cfloop array="#tweets.statuses#" index="tweet">
			<cfset var user = tweet.user>
			<cfset var created = new Date(tweet.created_at)>
			
			<cfoutput >
				<cfsavecontent variable="tmphtml" >
					<div>
				
						 <blockquote class="twitter-tweet" lang="en">
						   <p>#tweet.text#</p>
						   &mdash; #user.name# (@#user.screen_name#) 
						   <a href="https://twitter.com/#user.screen_name#/statuses/#tweet.id_str#">
                                                       #eval("created.toLocaleDateString()")#  &nbsp;&nbsp;&nbsp; #eval("created.toLocaleTimeString()")#
                                                   </a>
						 </blockquote>
                                                 <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


					</div>    
				</cfsavecontent>
			</cfoutput>
			<cfset $(table_obj).append(tmphtml)>
			
		</cfloop>
		<cfscript>
			
			$(".tweetbutton").click(function(event) {
				var tweet = document.getElementById('tweet').value;
				display_tweets(tweet,document.getElementById('tweetcount').value);
			});

			
	</cfscript>
		<cfset  $(table_obj).append('</div>')>	
		<cfset $('##progid').css('display', 'none')>
	</cffunction>
	
	<cffunction name="openInBrowser" >
		<cfargument name="url" >
		<cfset window.open(encodeURI(url),"_system")>
	</cffunction>

	
	
</cfclient>

