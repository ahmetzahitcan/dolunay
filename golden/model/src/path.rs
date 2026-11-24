use crate::{geometry::THREADS_PER_WARP, path::SplitResult::{AllPassing, AllTaking}, thread::Thread};

pub enum SplitResult {
    AllTaking(Path),
    AllPassing(Path),
    Divergence{taking: Path, passing: Path}
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Path {
    pub threads: Vec<Box<Thread>>,
    pub pc: u32,
}

impl Path {
    pub fn empty(pc: u32) -> Self {
        let tvec = Vec::with_capacity(THREADS_PER_WARP);
        Path {
            threads: tvec,
            pc
        }
    }

    pub fn new(pc: u32, threads: impl Iterator<Item = Thread>) -> Self {
        let mut tvec = Vec::with_capacity(THREADS_PER_WARP);
        for t in threads {
            tvec.push(Box::new(t));
        }
        Path {
            threads: tvec,
            pc
        }
    }

    pub fn split(mut self, predicate: impl Fn(&Thread) -> bool) -> SplitResult {
        let (takers, passers) = 
            self.threads.drain(..).partition::<Vec<_>, _>(|t | predicate(t));

        match (takers.is_empty(), passers.is_empty()) {
            (true, true) => unreachable!(), // This is impossible: the active path has at least one thread, and every thread either takes or passes the branch.
            (true, false) => {
                // All threads pass the branch, so the active path continues.
                self.threads = passers;
                AllPassing(self)
            }, 
            (false, true) => {
                // All threads take the branch, so the active path continues.
                self.threads = takers;
                AllTaking(self)
            },  
            (false, false) => {
                // Branch divergence

                todo!()
            }
        }
    }

    pub fn thread(&self, thread_id: u16) -> Option<&Thread> {
        for t in &self.threads {
            if t.thread_id == thread_id {
                return Some(t);
            }
        }
        None
    }

    pub fn thread_mut(&mut self, thread_id: u16) -> Option<&mut Thread> {
        for t in &mut self.threads {
            if t.thread_id == thread_id {
                return Some(t);
            }
        }
        None
    }

    pub fn threads(&self) -> impl Iterator<Item = &Thread> {
        self.threads.iter().map(|t| Box::as_ref(t))
    }

    pub fn threads_mut(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.threads.iter_mut().map(|t| Box::as_mut(t))
    }
}