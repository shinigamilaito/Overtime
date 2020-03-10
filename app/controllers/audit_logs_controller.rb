class AuditLogsController < ApplicationController
  def index
    authorize AuditLog
    @audit_logs = AuditLog.page(params[:page]).per(10)
  end
end
