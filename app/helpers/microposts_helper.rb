module  MicropostsHelper
  
  def warp(content)
    sanitize(raw(content.split.map { |s| warp_long_string(s) }.join(' ')))
  end
  
  private
  
    def warp_long_string(text,max_width=30)
      zero_with_space = '&#8203;'
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text  :
                                  text.scan(regex).join(zero_with_space)
    end
end