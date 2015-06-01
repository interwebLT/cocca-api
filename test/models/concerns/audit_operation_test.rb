require 'test_helper'

describe AuditOperation do
  INSERT_OPERATION = AuditOperation::INSERT_OPERATION
  UPDATE_OPERATION = AuditOperation::UPDATE_OPERATION
  DELETE_OPERATION = AuditOperation::DELETE_OPERATION

  class TestModel
    include ActiveModel::Model
    include AuditOperation

    attr_accessor :audit_operation
  end

  describe :insert_operation? do
    specify { TestModel.new(audit_operation: INSERT_OPERATION).insert_operation?.must_equal true }
    specify { TestModel.new(audit_operation: UPDATE_OPERATION).insert_operation?.must_equal false }
    specify { TestModel.new(audit_operation: DELETE_OPERATION).insert_operation?.must_equal false }
  end

  describe :update_operation? do
    specify { TestModel.new(audit_operation: UPDATE_OPERATION).update_operation?.must_equal true }
    specify { TestModel.new(audit_operation: INSERT_OPERATION).update_operation?.must_equal false }
    specify { TestModel.new(audit_operation: DELETE_OPERATION).update_operation?.must_equal false }
  end

  describe :delete_operation? do
    specify { TestModel.new(audit_operation: DELETE_OPERATION).delete_operation?.must_equal true }
    specify { TestModel.new(audit_operation: INSERT_OPERATION).delete_operation?.must_equal false }
    specify { TestModel.new(audit_operation: UPDATE_OPERATION).delete_operation?.must_equal false }
  end
end
