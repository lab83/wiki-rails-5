# Work around for getting Draper working in Rails 5.
# See: https://github.com/drapergem/draper/issues/681#issuecomment-220151049
class Rails::SubTestTask < Rake::TestTask
end
