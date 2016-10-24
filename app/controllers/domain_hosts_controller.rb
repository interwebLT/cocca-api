class DomainHostsController < SecureController
  def create
    unless params[:bulk].nil?
      create_delete_bulk
    else
      domain_host = DomainHost.new  partner: current_partner,
                                    domain: params[:domain_id],
                                    name:   params[:name]

      unless params[:old_name].nil?
        old_domain_host = DomainHost.new  partner:  current_partner,
                                          domain:   params[:domain_id],
                                          name:     params[:old_name]

        if old_domain_host.destroy
          create_domain_host domain_host
        else
          head :unprocessable_entity
        end
      else
        create_domain_host domain_host
      end
    end
  end

  def destroy
    domain_host = DomainHost.new  partner:  current_partner,
                                  domain:   params[:domain_id],
                                  name:     params[:id]

    if domain_host.destroy
      render json: domain_host
    else
      head :unprocessable_entity
    end
  end

  def create_delete_bulk
    new_list    = params[:domain_host_add] ? params[:domain_host_add].join(',') : ""
    delete_list = params[:domain_host_delete] ? params[:domain_host_delete].join(',') : ""
    new_domain_host = DomainHost.new  partner: current_partner,
                                      domain: params[:domain_id],
                                      name: new_list

    remove_domain_host = DomainHost.new  partner: current_partner,
                                      domain: params[:domain_id],
                                      name: delete_list

    if delete_list.blank?
      create_domain_host new_domain_host
    else
      if remove_domain_host.destroy
        create_domain_host new_domain_host
      else
        head :unprocessable_entity
      end
    end
  end

  def create_domain_host domain_host
    if domain_host.create
      render json: domain_host
    else
      head :unprocessable_entity
    end
  end
end
