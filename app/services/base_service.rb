class BaseService
  include ActiveModel::Model

  attr_reader :result, :errors

  def initialize
    super()
    @errors = []
    @result = nil
  end

  def self.call(args = nil)
    new(args).call
  end

  def self.call!(args = nil)
    new(args).call!
  end

  def call!
    validate!
    call
  end

  def call(*args, **kwargs)
    raise NotImplementedError, "Subclasses must implement the call method"
  end

  def success?
    errors.empty?
  end

  def failure?
    !success?
  end

  private

  def add_error(error)
    @errors << error
  end

  def set_result(value)
    @result = value
  end
end
