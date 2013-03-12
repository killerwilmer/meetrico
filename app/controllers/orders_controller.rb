class OrdersController < ApplicationController
  def express
    #p current_cart.inspect
    #p current_cart.build_order.price_in_cents.to_s
    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => products_url
    )
    #p response.token.to_s
#
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def new
    
    @order = Order.new(:express_token => params[:token])
    @cart = current_cart
    #p @order.inspect
  end
  
  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase
        render :action => "success"
      else
        render :action => "failure"
      end
    else
      render :action => 'new'
    end
  end
end
#
#"#<ActiveMerchant::Billing::PaypalExpressResponse:0xb0611d8
#@params={"timestamp"=>"2011-09-08T01:06:13Z",
#"ack"=>"Success",
#"correlation_id"=>"819bbf138f5f8",
#"version"=>"62.0",
#"build"=>"2085867",
#"token"=>"EC-48N67363XK026661Y",
#"payer"=>"dfbuy_1314995554_per@gmail.com",
#"payer_id"=>"4D3FQQQJSR2JC",
#"payer_status"=>"verified",
#"salutation"=>nil,
#"first_name"=>"Test",
#"middle_name"=>nil,
#"last_name"=>"User",
#"suffix"=>nil,
#"payer_country"=>"US",
#"payer_business"=>nil,
#"name"=>"Test User",
#"street1"=>"1 Main St",
#"street2"=>nil,
#"city_name"=>"San Jose",
#"state_or_province"=>"CA",
#"country"=>"US",
#"country_name"=>"United States",
#"postal_code"=>"95131",
#"address_owner"=>"PayPal",
#"address_status"=>"Confirmed",
#"order_total"=>"300.00",
#"order_total_currency_id"=>"USD",
#"shipping_total"=>"0.00",
#"shipping_total_currency_id"=>"USD",
#"handling_total"=>"0.00",
#"handling_total_currency_id"=>"USD",
#"tax_total"=>"0.00",
#"tax_total_currency_id"=>"USD",
#"phone"=>nil,
#"address_id"=>nil,
#"external_address_id"=>nil,
#"insurance_total"=>"0.00",
#"insurance_total_currency_id"=>"USD",
#"shipping_discount"=>"0.00",
#"shipping_discount_currency_id"=>"USD",
#"insurance_option_offered"=>"false",
#"seller_details"=>nil,
#"payment_request_id"=>nil,
#"order_url"=>nil,
#"soft_descriptor"=>nil,
#"checkout_status"=>"PaymentActionNotInitiated",
#"Token"=>"EC-48N67363XK026661Y",
#"PayerInfo"=>{"Payer"=>"dfbuy_1314995554_per@gmail.com",
#  "PayerID"=>"4D3FQQQJSR2JC",
#  "PayerStatus"=>"verified",
#  "PayerName"=>{"Salutation"=>nil,
#    "FirstName"=>"Test",
#    "MiddleName"=>nil,
#    "LastName"=>"User",
#    "Suffix"=>nil},
#    "PayerCountry"=>"US",
#    "PayerBusiness"=>nil,
#    "Address"=>{"Name"=>"Test User",
#      "Street1"=>"1 Main St",
#      "Street2"=>nil,
#      "CityName"=>"San Jose",
#      "StateOrProvince"=>"CA",
#      "Country"=>"US",
#      "CountryName"=>"United States",
#      "PostalCode"=>"95131",
#      "AddressOwner"=>"PayPal",
#      "AddressStatus"=>"Confirmed"}
#   },
#    "PaymentDetails"=>{"OrderTotal"=>"300.00",
#    "ShippingTotal"=>"0.00",
#    "HandlingTotal"=>"0.00",
#    "TaxTotal"=>"0.00",
#    "ShipToAddress"=>{"Name"=>"Test User", "Street1"=>"1 Main St", "Street2"=>nil, "CityName"=>"San Jose", "StateOrProvince"=>"CA", "Country"=>"US", "CountryName"=>"United States", "Phone"=>nil, "PostalCode"=>"95131", "AddressID"=>nil, "AddressOwner"=>"PayPal", "ExternalAddressID"=>nil, "AddressStatus"=>"Confirmed"}, "InsuranceTotal"=>"0.00", "ShippingDiscount"=>"0.00", "InsuranceOptionOffered"=>"false", "SellerDetails"=>nil, "PaymentRequestID"=>nil, "OrderURL"=>nil, "SoftDescriptor"=>nil}, "CheckoutStatus"=>"PaymentActionNotInitiated"}, @message="Success", @success=true, @test=true, @authorization=nil, @fraud_review=false, @avs_result={"code"=>nil, "message"=>nil, "street_match"=>nil, "postal_match"=>nil}, @cvv_result={"code"=>nil, "message"=>nil}>"
