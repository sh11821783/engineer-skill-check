class EmployeesController < ApplicationController
  require 'csv' # ←csvに必要
  before_action :set_employee, only: %i(edit update destroy)
  before_action :set_form_option, only: %i(new create edit update)

  def index
    @employees = Employee.active.order("#{sort_column} #{sort_direction}").page(params[:page]).per(5)
    # respond_to はリクエストに応じた処理を行うメソッドです。
    # 通常時はhtmlをリクエストしているので、処理は記述していません。
    # viewのlink_toでformatをcsvとして指定しているので、
    # リンクを押すとsend_posts_csv(@employees)の処理を行います。
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_employees_csv(@employees)
      end
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    add_params

    if @employee.save
      redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    add_params

    if @employee.update(employee_params)
      redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      now = Time.now
      @employee.update_column(:deleted_at, now)
      @employee.profiles.active.first.update_column(:deleted_at, now) if @employee.profiles.active.present?
    end

    redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を削除しました。"
  end

  private

  def employee_params
    params.require(:employee).permit(:number, :last_name, :first_name, :email, :date_of_joining, :account, :password, :department_id, :office_id, :employee_info_manage_auth)
  end

  def set_employee
    @employee = Employee.find(params["id"])
  end

  def set_form_option
    @departments = Department.all
    @offices = Office.all
  end

  # 現在、メールアドレスと入社日は入力できないため、ここで追加しています。
  def add_params
    unless @employee.email
      @employee.email = 'sample@example.com'
    end
    unless @employee.date_of_joining
      @employee.date_of_joining = Date.today
    end
  end

  def sort_column
    params[:sort] ? params[:sort] : 'number'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end

  # CSV.generateとは、対象データを自動的にCSV形式に変換してくれるCSVライブラリの一種
  def send_employees_csv(employees)
    csv_data = CSV.generate do |csv|
      # %w()は、空白で区切って配列を返します
      column_names = %w(社員番号 姓 名 メールアドレス 入社年月日)
      # csv << column_namesは表の列に入る名前を定義します。
      csv << column_names
      # column_valuesに代入するカラム値を定義します。
      employees.each do |employee|
        column_values = [
          employee.number,
          employee.first_name,
          employee.last_name,
          employee.email,
          employee.date_of_joining,
        ]
        # csv << column_valueshは表の行に入る値を定義します。
        csv << column_values
      end
    end
    # csv出力のファイル名を定義します。
    send_data(csv_data, filename: "社員情報一覧.csv")
  end
end
