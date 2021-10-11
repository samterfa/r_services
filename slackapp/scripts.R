
push_opening_view <- function(req){
  
  print(Sys.getenv('slack_auth_token'))
  
  views_open(token = Sys.getenv('slack_auth_token'), 
             trigger_id = req$body$trigger_id, 
             view = view_object(type = 'modal', 
                                title = text_object(type = 'plain_text', 
                                                    text = 'Testing', 
                                                    emoji = F), 
                                blocks = list(context_block(elements = list(image_element(image_url = 'https://api.time.com/wp-content/uploads/2019/03/kitten-report.jpg',
                                                                                          alt_text = 'Cutest Kitty')
                                ), 
                                block_id = 'action_button')), 
                                close = text_object(type = 'plain_text', 
                                                    text = 'Close', 
                                                    emoji = F), 
                                submit = text_object(type = 'plain_text', 
                                                     text = 'Next', 
                                                     emoji = F), 
                                private_metadata = '', 
                                callback_id = '', 
                                clear_on_close = F, 
                                notify_on_close = F, 
                                external_id = ''), 
             return_response = T)
}


push_next_view <- function(req){
  
  require(dplyr)
  require(slackme)
  
  print(Sys.getenv('slack_auth_token'))
  
  payload <- jsonlite::fromJSON(req$body$payload, F, F, F, F)
  
  view_id <- payload$view$root_view_id
  view_hash <- payload$view$hash
  trigger_id <- payload$trigger_id
  
  response <- httr::POST('https://slack.com/api/views.push', 
                         
                         body =  glue::glue(.open = "{{{{{", .close = "}}}}}", '
                         {
  "trigger_id": "{{{{{trigger_id}}}}}",
  {
	"type": "modal",
	"title": {
		"type": "plain_text",
		"text": "My App",
		"emoji": true
	},
	"submit": {
		"type": "plain_text",
		"text": "Submit",
		"emoji": true
	},
	"close": {
		"type": "plain_text",
		"text": "Cancel",
		"emoji": true
	},
	"blocks": [
		{
			"type": "divider"
		},
		{
			"type": "actions",
			"elements": [
				{
					"type": "button",
					"text": {
						"type": "plain_text",
						"text": "Kin Khao",
						"emoji": true
					},
					"value": "click_me_123",
					"url": "https://google.com"
				},
				{
					"type": "button",
					"text": {
						"type": "plain_text",
						"text": "Ler Ros",
						"emoji": true
					},
					"value": "click_me_123",
					"url": "https://google.com"
				}
			]
		},
		{
			"type": "image",
			"title": {
				"type": "plain_text",
				"text": "I Need a Marg",
				"emoji": true
			},
			"image_url": "https://sheets-uipbq6t2ga-uc.a.run.app/image.png",
			"alt_text": "marg"
		}
	]
}}'), 

encode = 'json', 

httr::content_type_json(), 

httr::add_headers(Authorization = glue::glue('Bearer {Sys.getenv("slack_auth_token")}')))
  
  print(glue::glue(.open = "{{{{{", .close = "}}}}}", '
                         {
  "trigger_id": "{{{{{trigger_id}}}}}",
  {
	"type": "modal",
	"title": {
		"type": "plain_text",
		"text": "My App",
		"emoji": true
	},
	"submit": {
		"type": "plain_text",
		"text": "Submit",
		"emoji": true
	},
	"close": {
		"type": "plain_text",
		"text": "Cancel",
		"emoji": true
	},
	"blocks": [
		{
			"type": "divider"
		},
		{
			"type": "actions",
			"elements": [
				{
					"type": "button",
					"text": {
						"type": "plain_text",
						"text": "Kin Khao",
						"emoji": true
					},
					"value": "click_me_123",
					"url": "https://google.com"
				},
				{
					"type": "button",
					"text": {
						"type": "plain_text",
						"text": "Ler Ros",
						"emoji": true
					},
					"value": "click_me_123",
					"url": "https://google.com"
				}
			]
		},
		{
			"type": "image",
			"title": {
				"type": "plain_text",
				"text": "I Need a Marg",
				"emoji": true
			},
			"image_url": "https://sheets-uipbq6t2ga-uc.a.run.app/image.png",
			"alt_text": "marg"
		}
	]
}}'))
  
  print(httr::content(response))
  
  return('')
}