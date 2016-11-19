class Juman
  class Morpheme
    def initialize(line)
      if line =~ /\A /
        attributes = [" ", " ", " ", "特殊", "1", "空白", "6", "*", "0", "*", "0", "NIL"]
      elsif line =~ /\A@ /
        line = line.sub(/\A@ /, '')
        attributes = line.split(/\s/)
      else
        attributes = line.split(/\s/)
      end
      @surface, @pronunciation, @base, @pos = attributes.shift(4)
      @pos_id, @pos_spec_id, @type_id, @form_id =
        attributes.values_at(0, 2, 4, 6).map{|id_str| id_str.to_i }
      @pos_spec, @type, @form =
        attributes.values_at(1, 3, 5).map{|attr| normalize_attr(attr) }
      # @info = normalize_info(attributes[7..-1].join(' '))
    end
    attr_reader :surface, :pronunciation, :base, :pos, :pos_id, :pos_spec,
      :pos_spec_id, :type, :type_id, :form, :form_id
    #, :info

    private
    def normalize_attr(candidate)
      if candidate == '*'
        nil
      else
        candidate
      end
    end

    # def normalize_info(candidate)
    #   if candidate == 'NIL'
    #     nil
    #   else
    #     eval(candidate)
    #   end
    # end
  end
end
