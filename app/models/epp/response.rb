module EPP
  class Response
    def tr_id
      @xml.find('/e:epp/e:response/e:trID/e:svTRID').first.content
    end
  end
end