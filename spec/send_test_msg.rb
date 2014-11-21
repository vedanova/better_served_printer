require 'pusher'
Pusher.url = "http://fad5ae28dbb7ec8973d5:7bcbe57b920af30231cb@api.pusherapp.com/apps/66347"
message = "\u001D!\u0011Rechnung\n\u001D!\u0000Table: 123 \n\u001D!\u0000Nr. of People: 3\n\u001D!\u0000------------------------------------------\n\u001D!\u0011\ea\u0001Table: Table 2\n\n\u001D!\u0000------------------------------------------\n\u001D!\u0000Rechnungs Nr.: 123444\n\u001D!\u0000Es bediente Sie: Christoph Klocker\n"
Pusher['private_6fbe7751-0ebb-4cea-83d5-e7580c7afd37_notifications'].trigger('message', {  message: message })

