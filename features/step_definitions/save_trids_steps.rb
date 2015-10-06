Then(/^transaction ID must be saved$/) do
  assert_not_nil TrId.find_by tr_id: '54321-XYZ'
end
