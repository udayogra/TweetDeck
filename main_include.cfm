<cfclient>
	<cfscript>
		
			
		function onDocumentInit()
		{
			
			//Create CFC for getting tweets
			window.tweet_util = new tweet_utils.TweetSearchUtils();
			switchPage("tweets");			
		}
				
	</cfscript>

	
	
	<cffunction name="switchPage" >
		<cfargument name="pageName">
		
		<cfset $("##"+window.mainDivId).children().remove()>
		<cfset $("##"+window.mainDivId).html("")>
		<cf_tweets>
		
	</cffunction>

	
	
</cfclient>