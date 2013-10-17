# encoding: utf-8
module ApplicationHelper

    # Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "dAre.se"
        
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def get_project
        project = Project.find(:first, :order => 'year DESC')
    end

end
