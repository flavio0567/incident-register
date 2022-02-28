import { Request, Response } from "express";
import { prisma } from "../../../../../shared/infra/prisma/primaClient";

import { CreateUserUseCase } from "../../../useCases/createUser/CreateUserUseCase";
export class CreateUserController {
  async create(request: Request, response: Response) {
    const { name, email, password_hash } = request.body;

    // check if user exist
    const clientExist = await prisma.users.findFirst({
      where: { email }
    })

    if (clientExist) {
      return response.status(400).json({ error: 'Duplicated e-mail!'});
    }

    const createUserUseCase = new CreateUserUseCase();

    const result = await createUserUseCase.execute({
      name,
      email,
      password_hash,
    });

    return response.json(result);
  }
}