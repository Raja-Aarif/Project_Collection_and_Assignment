class RelationshipsController < ApplicationController
    before_action :logged_in_user

    def new
        @all_teams = Team.all
        if current_user.is_member_of.present?
            flash[:danger] = 'You are already a member of a team'
            redirect_to teams_path
        else
            @team = Team.new
        end
    end

    def create
        @team = Team.find_by(code: params[:relationship][:code])

        @all_teams = Team.all

        if @team
            if Relationship.find_by(user_id: current_user.id, team_id: @team.id)
                flash[:warning] = 'You are already a member'
                redirect_to @team

            elsif Relationship.where(team_id: @team_id).count >= 6
                flash[:danger] = 'Sorry, this team has already reached the capacity of 6 members. Try finding a new team . . . '
                render 'new'

            else
                current_user.relationships.create(team_id: @team.id)
                flash[:success] = 'Team joined successfully'
                redirect_to @team
            end
        else
            flash.now[:danger] = 'Code is wrong'
            render 'new'
        end
    end
    
    def change_team2
        @team = Team.find_by(name: params[:team_name])
        @user = User.find_by(uin: params[:user_uin])

        print @team.name
       
        @r=Relationship.find_by(user_id: @user.id)
        if Relationship.find_by(user_id: @user.id, team_id: @team.id)
            
            flash[:warning] = 'You are already a member of this team'
            redirect_to users_path
            return
        end
        
        
        if Relationship.where(team_id: @team.id).count >= 6
            flash[:danger] = 'Sorry, this team has already  6 members. Please try a different team '
            redirect_to users_path
            return
        end

        @r.team_id= @team.id
        @r.save
        flash[:success] = 'Successfully changed '+  @user.firstname+' ' + @user.lastname + ' team to ' +@team.name
        redirect_to users_path
        


    end
    
    
    def change_team
        @team_names = []
        @project_names = []
        @curri_user = []
        curr_user = User.find(params[:user_id])
        @curri_user << curr_user.firstname+curr_user.lastname
        @curri_uin = []

        @curri_uin << curr_user.uin
       
        Team.find_each do |team|
            @team_names << team.name
        end
        Project.find_each do |project|
            @project_names << project.title
        end


    end
    

    
    
    
    

    def destroy
        @r = Relationship.find_by(id: params[:id])
        @team = Team.find_by(id: @r.team_id)
        if !@team
            flash[:danger] = 'Critical Error'
            redirect_to root_url
        elsif @team.is_leader?(current_user)
            flash[:danger] = 'Team leader cannot leave team'
            redirect_to @team
        else
            @r.destroy
            flash[:success] = 'Successfully left team'
            redirect_to request.referrer || root_url
        end
    end
end
