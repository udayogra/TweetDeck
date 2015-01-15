
component client="true"
{
	var cb = new Codebird(); //JS library to fetch tweets
	var bearerToken = "YOUR-BEARER-TOKEN-HERE";
	
	function search_tweets (searchText, count, callbackFunc)
	{
		try
		{
		var cb = new Codebird();
			cb.setBearerToken(bearerToken);
			cb.__call(
	    		"search_tweets",
	    		"count=" +  count +  "&q=" + searchText,
	    		callbackFunc,
	    		true 
			); 
		} 
		catch (any e)
		{
			alert("Error : " + e);
		}
	}
	
	function setBearerToken (token)
	{
		bearerToken = token;
	}
	
	function getBearerToken (consumer_key, consumer_secret)
	{
		cb.setConsumerKey(consumer_key,consumer_secret);
		cb.__call(
		   	"oauth2_token",
		   	{},
		   	setBearerToken
		);
	}
	
}