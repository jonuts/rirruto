class Rirruto::Mail::Message < OpenStruct
  class << self ; attr_accessor :queue ; end

  def initialize(args={})
    super
    add_self_to_queue
  end

  attr_accessor :sent

  def sent?
    !!@sent
  end

  private

  def add_self_to_queue
    self.class.queue ||= []
    self.class.queue << self
  end
end


