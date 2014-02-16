# encoding: utf-8
class Class
  # Fix for https://github.com/rails/rails/issues/12833
  def descendants # :nodoc:
    descendants = []
    ObjectSpace.each_object(Class) do |k|
      descendants.unshift k if k < self rescue nil
    end
    descendants.uniq!
    descendants
  end
end