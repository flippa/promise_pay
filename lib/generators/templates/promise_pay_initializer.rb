require "promise_pay"

PromisePay.api_user = "<%= email %>"
PromisePay.api_key  = "<%= token %>"

# Consider having this read from config
PromisePay.env      = :<%= env %>
