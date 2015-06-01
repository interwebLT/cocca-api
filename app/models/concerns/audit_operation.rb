require 'active_support/concern'

module AuditOperation
  extend ActiveSupport::Concern

  INSERT_OPERATION = 'I'
  UPDATE_OPERATION = 'U'
  DELETE_OPERATION = 'D'

  def insert_operation?
    self.audit_operation == 'I'
  end

  def update_operation?
    self.audit_operation == 'U'
  end

  def delete_operation?
    self.audit_operation == 'D'
  end
end
