
module AcceptanceSupport

  def screenshot(file='test1.png')
    if page.driver.respond_to? :render
      page.driver.render file
    else
      puts "no render methode"
    end
  end

  def show_page
    save_and_open_page
  end
end
