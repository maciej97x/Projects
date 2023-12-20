<?php
// src/Controller/PostController.php

namespace App\Controller;

use App\Entity\Post;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PostController extends AbstractController
{
    /**
     * @Route("/lista", name="post_list")
     */
    public function lista(EntityManagerInterface $entityManager): Response
    {
        $posts = $entityManager->getRepository(Post::class)->findAll();

        return $this->render('post/lista.html.twig', [
            'posts' => $posts,
        ]);
    }

    /**
     * @Route("/post/usun/{id}", name="post_delete")
     */
    public function usun(Post $post, EntityManagerInterface $entityManager): Response
    {
        $entityManager->remove($post);
        $entityManager->flush();

        return $this->redirectToRoute('post_list');
    }
}

