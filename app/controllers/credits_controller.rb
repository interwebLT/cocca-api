class CreditsController < SecureController
  def create
    client = Cocca::Client.find_by_name(credit_params[:partner])

    unless client.nil?
      ledger_id     = Cocca::Ledger.connection.select_value("SELECT nextval('ledger_id_seq')")

      cocca_ledger               = Cocca::Ledger.new
      cocca_ledger.id            = ledger_id
      cocca_ledger.client_roid   = client.roid
      cocca_ledger.description   = credit_params[:remarks]
      cocca_ledger.currency      = credit_params[:amount_currency]
      cocca_ledger.trans_type    = "Adjustment"
      cocca_ledger.balance       = credit_params[:amount_cents]
      cocca_ledger.total         = credit_params[:amount_cents] * -1
      cocca_ledger.amount        = credit_params[:amount_cents] * -1
      cocca_ledger.tax_content   = 0
      cocca_ledger.tld           = "ph"
      cocca_ledger.tax_inclusive = false

      if cocca_ledger.save!
        render json: cocca_ledger
      else
        render validation_failed cocca_ledger
      end
    else
      render json: {}
    end
  end

  private

  def credit_params
    params.permit :partner, :type, :status, :amount_cents, :amount_currency, :remarks, :credit_number,
      :fee_cents, :fee_currency
  end
end
