class VmControlJob
  include Sidekiq::Job

  def perform(order_id)
    StopVmService.call(order_id)
  end
end
