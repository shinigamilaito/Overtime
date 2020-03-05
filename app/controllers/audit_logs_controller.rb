class AuditLogsController < ApplicationController
  def index
    authorize AuditLog
    @audit_logs = AuditLog.all
  end
end
