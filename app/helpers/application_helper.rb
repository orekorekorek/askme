module ApplicationHelper
  def inclination(count, entity)
    if (10..20).include?(count % 100)
      entity[2]
    else
      case count % 10
      when 1 then entity[0]
      when 2..4 then entity[1]
      else
        entity[2]
      end
    end
  end
end
