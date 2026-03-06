require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#youtube_video" do
    it "returns an iframe with the video id" do
      result = helper.youtube_video("abc123")

      expect(result).to include("https://www.youtube.com/embed/abc123")
      expect(result).to include("iframe")
      expect(result).to include('allowfullscreen')
      expect(result).to include('loading="lazy"')
    end

    it "uses custom title" do
      result = helper.youtube_video("abc123", title: "My Video")

      expect(result).to include('title="My Video"')
    end

    it "escapes video id to prevent XSS" do
      result = helper.youtube_video('<script>alert("xss")</script>')

      expect(result).not_to include("<script>")
    end
  end

  describe "#admin?" do
    it "returns true when current user is admin" do
      admin = create(:admin)
      session = admin.sessions.create!(user_agent: "test", ip_address: "127.0.0.1")
      Current.session = session

      expect(helper.admin?).to be true
    end

    it "returns false when current user is not admin" do
      user = create(:user)
      session = user.sessions.create!(user_agent: "test", ip_address: "127.0.0.1")
      Current.session = session

      expect(helper.admin?).to be false
    end

    it "returns nil when no user is logged in" do
      Current.session = nil

      expect(helper.admin?).to be_nil
    end
  end

  describe "#current_user" do
    it "returns the current user from session" do
      user = create(:user)
      session = user.sessions.create!(user_agent: "test", ip_address: "127.0.0.1")
      Current.session = session

      expect(helper.current_user).to eq(user)
    end

    it "returns nil when no session" do
      Current.session = nil

      expect(helper.current_user).to be_nil
    end
  end

  describe "#format_time" do
    it "formats time as HH:MM" do
      time = Time.zone.parse("2026-03-06 14:30")

      expect(helper.format_time(time)).to eq("14:30")
    end

    it "returns nil for nil input" do
      expect(helper.format_time(nil)).to be_nil
    end
  end

  describe "#format_date" do
    it "formats date as DD.MM.YYYY" do
      date = Date.new(2026, 3, 6)

      expect(helper.format_date(date)).to eq("06.03.2026")
    end

    it "returns nil for nil input" do
      expect(helper.format_date(nil)).to be_nil
    end
  end

  describe "#format_datetime" do
    it "formats datetime as DD.MM.YYYY HH:MM" do
      datetime = Time.zone.parse("2026-03-06 14:30")

      expect(helper.format_datetime(datetime)).to eq("06.03.2026 14:30")
    end

    it "returns empty string for nil input" do
      expect(helper.format_datetime(nil)).to eq("")
    end
  end

  describe "#boolean_value" do
    it "returns 'Ja' for true" do
      expect(helper.boolean_value(true)).to eq("Ja")
    end

    it "returns 'Nein' for false" do
      expect(helper.boolean_value(false)).to eq("Nein")
    end

    it "returns empty string for nil" do
      expect(helper.boolean_value(nil)).to eq("")
    end
  end

  describe "button helpers" do
    describe "#new_button" do
      it "renders a link with plus icon" do
        result = helper.new_button("/admin/users")

        expect(result).to include("fa-plus")
        expect(result).to include("Neu")
        expect(result).to include("/admin/users")
      end
    end

    describe "#edit_button" do
      it "renders a link with pen icon" do
        result = helper.edit_button("/admin/users/1/edit")

        expect(result).to include("fa-pen")
        expect(result).to include("Ändern")
      end
    end

    describe "#delete_button" do
      it "renders a link with trash icon and confirmation" do
        result = helper.delete_button("/admin/users/1")

        expect(result).to include("fa-trash")
        expect(result).to include("Löschen")
        expect(result).to include("turbo-confirm")
      end
    end

    describe "#back_button" do
      it "renders a link with arrow-left icon" do
        result = helper.back_button("/admin")

        expect(result).to include("fa-arrow-left")
        expect(result).to include("/admin")
      end
    end

    describe "#cancel_button" do
      it "renders a danger button with ban icon" do
        result = helper.cancel_button("/admin")

        expect(result).to include("fa-ban")
        expect(result).to include("Abbrechen")
        expect(result).to include("btn-danger")
      end
    end
  end
end
