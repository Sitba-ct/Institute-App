import axios from "axios";
import IRole from "./IRole";
import IUserRole from "./IUserRole";
import IUserRoleService from "./IUserRoleService";
import { injectable } from "tsyringe";
@injectable()
export class UserRoleService implements IUserRoleService {
  async newUserRole(userId: string, roleId: number): Promise<IUserRole> {
    let response = await axios
      .post("/rest/v1/userRoles", {
        userId: userId,
        roleId: roleId,
      })
      .catch((error) => {
        console.log(error.toJSON());
        throw error;
      });
    return response.data[0];
  }
  async deleteUserRole(userId: number): Promise<IUserRole> {
    let response = await axios
      .post("/rest/v1/userRoles?id=eq." + userId)
      .catch((error) => {
        console.log(error.toJSON());
        throw error;
      });
    return response.data[0];
  }
  async initRoles(): Promise<IRole[]> {
    let response = await axios.get("/rest/v1/roles").catch((error) => {
      console.log(error.toJSON());
      throw error;
    });
    return response.data;
  }
}
