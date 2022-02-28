import { prisma } from "../../../../shared/infra/prisma/primaClient";
interface ICreateUser {
  name: string;
  email: string;
  password_hash: string;
}
export class CreateUserUseCase {
  async execute({ name, email, password_hash }: ICreateUser) {

    // save user
    const user = await prisma.users.create({
      data: {
        name,
        email,
        password_hash,
      }
    });
    return user.id;
  }

}