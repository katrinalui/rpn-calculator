class RPNCalculator
  def initialize
    @stack = []
  end

  def push(number)
    @stack << number
  end

  def value
    @stack.last
  end

  def plus
    perform_operation(:+)
  end

  def minus
    perform_operation(:-)
  end

  def times
    perform_operation(:*)
  end

  def divide
    perform_operation(:/)
  end

  def tokens(string)
    tokens = string.split
    tokens.map { |char| is_operation?(char) ? char.to_sym : char.to_i }
  end

  def evaluate(string)
    tokens = tokens(string)

    tokens.each do |token|
      case token
      when Integer
        push(token)
      else
        perform_operation(token)
      end
    end

    value
  end

  private

  def perform_operation(op_symbol)
    raise "calculator is empty" if @stack.size < 2

    num2 = @stack.pop
    num1 = @stack.pop

    case op_symbol
    when :+
      @stack << num1 + num2
    when :-
      @stack << num1 - num2
    when :*
      @stack << num1 * num2
    when :/
      @stack << num1.fdiv(num2)
    else
      @stack << num1
      @stack << num2
      raise "No such operation #{op_symbol}"
    end
  end

  def is_operation?(char)
    [:+, :-, :*, :/].include?(char.to_sym)
  end
end
